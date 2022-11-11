; sql
((string) @sql (#contains? @sql "SELECT" "INSERT" "UPDATE" "DELETE" "CREATE" "ALTER") (#offset! @sql 1 0 -1 0))

