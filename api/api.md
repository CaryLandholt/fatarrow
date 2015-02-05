FORMAT: 1A

# Matchup API

## URI Syntax
[RFC 3986](http://tools.ietf.org/html/rfc3986#section-3)

```
https://api.matchup.io/resources?offset=10#bottom
\___/   \____________/ \_______/ \_______/ \____/
  |            |           |         |        |
scheme      authority     path     query   fragment
```

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

# Group Companies

## Companies Collection [/companies]

### List all Companies [GET]
+ Response 200 (application/json)

+ Headers

Link: <https://api.matchup.io/companies>;rel="first",<https://api.matchup.io/companies?page=2>;rel="previous",<https://api.matchup.io/companies?page=4>;rel="next",<https://api.matchup.io/companies?page=11>;rel="last"

+ Body

[
{"id": 1, "name": "Apple"},
{"id": 2, "name": "Google"},
{"id": 3, "name": "Microsoft"}
]

### Create a Company [POST]
+ Request (application/json)

{"name": "IBM"}

+ Response 201 (application/json)

+ Headers

Location: https://api.matchup.io/companies/4

+ Body

{"id": 4}

## Company [/companies/{id}]

+ Parameters
+ id (required, number, `1`) ... Numeric `id` of the Company to perform action with.  Has example value.

### Retrieve a Company [GET]
+ Response 200 (application/json)

+ Body

{"id": 1, "name": "Apple"}

### Update a Company [PUT]
+ Request (application/json)

+ Body

{"name": "MS"}

+ Response 204 (application/json)

### Remove a Company [DELETE]
+ Response 204 (application/json)


# Group Users

## Users Collection [/users]

### List all Users [GET]
+ Response 200 (application/json)

[
{"id": 1, "name": "John"},
{"id": 2, "name": "Greg"},
{"id": 3, "name": "Anthony"}
]

### Create a User [POST]
+ Request (application/json)

{"name": "Andy"}

+ Response 201 (application/json)

+ Headers

Location: https://api.matchup.io/users/4

+ Body

{"id": 4}

## User [/users/{id}]

+ Parameters
+ id (required, number, `1`) ... Numeric `id` of the User to perform action with.  Has example value.

### Retrieve a User [GET]
+ Response 200 (application/json)

+ Body

{"id": 1, "name": "John"}

### Update a User [PUT]
+ Request (application/json)

+ Body

{"name": "JohnnyCon"}

+ Response 204 (application/json)

### Remove a User [DELETE]
+ Response 204 (application/json)