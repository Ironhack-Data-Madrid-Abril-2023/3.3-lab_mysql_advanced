select * from titles 
left join titleauthor 
on titles.title_id=titleauthor.title_id;