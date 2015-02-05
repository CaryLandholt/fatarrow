## REST

### Standards
- **resource properties**  
[snake case](http://en.wikipedia.org/wiki/Snake_case) formatting (e.g. start_date, company, average_steps_per_mile) must be used
- an eye tracking study concluded camel case takes 20% longer to comprehend than snake case ([snake case vs. camel case](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.421.6137&rep=rep1&type=pdf))
- **versioning**  
[SemVer](http://semver.org/) versioning must be used  
`major.minor.patch.build`
- **major** - breaking change(s)
- **minor** - new feature(s)
- **patch** - bug fix(s)
- **build** - build number

### Status Codes
| HTP Verb | Entire Collection (e.g. /resources)                                                        | Specific Item (e.g. /resources/{id})                                   |
|----------|--------------------------------------------------------------------------------------------|------------------------------------------------------------------------|
| GET      | 200 (OK), list of resources. Use pagination, sorting, and filtering to navigate big lists  | 200 (OK), single resource. 404 (Not Found), if id not found or invalid |
| PUT      | 404 (Not Found), unless you want to update/replace every resource in the entire collection | 204 (No Content). 404 (Not Found), if id not found or invalid          |
| POST     | 201 (Created), 'Location' header with link to /resources/{id} containing new id            | 404 (Not Found)                                                        |
| DELETE   | 404 (Not Found), unless you want to delete the entire collection                           | 200 (OK). 404 (Not Found), if id not found or invalid                  |

### Pagination

```
?page={pageNumber}&limit={limitReturnRecordsTo}
```

```
?page=2&limit=50
```

The above will retrieve records:
- 50-99 if there are atleast 99 records
- or 50-last_record if the last_record < 99
- or 0 records if the last_record < 50

If no pagination parameters are passed, the default page and limit are used

### Sorting

```
?sort={[-]fielda[,[-]fieldb[,...]]}
```

The `sort` parameter takes in a list of comma separated fields, each with a possible unary negative to imply descending sort order