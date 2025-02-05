with
ivanov_id as
(select author_id
from Author
where author_name='Иванов И.И.'), 

event_give as
(select e.date_event, e.typ_event as give, e.reader_id, e.book_id
from Event as e, book as b, ivanov_id as i_id
where b.author_id = i_id.author_id and e.book_id = b.book_id and e.typ_event = 0 and e.date_event between '2022-01-12' AND '2022-02-12'),

event_return as 
(
select e.date_event, e.typ_event as ret, e.reader_id, e.book_id
from Event as e, book as b, ivanov_id as i_id
where b.author_id = i_id.author_id and e.book_id = b.book_id and e.typ_event = 1 and e.date_event between '2022-01-12' AND '2022-02-12'),

event_not_ret as (
select g.date_event, g.reader_id, g.book_id
from event_give as g left join event_return as r
on g.reader_id = r.reader_id and g.book_id = r.book_id
where r.ret is null)

select b.book_name, r.reader_name, e.date_event as give_date
from event_not_ret as e, Book as b, Reader as r
where r.reader_id = e.reader_id and b.book_id = e.book_id
order by  r.reader_name, give_date desc;

