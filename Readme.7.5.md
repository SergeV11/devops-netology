# Домашнее задание к занятию "7.5. Основы golang"


## 1.

```
package main
import "fmt"

        func main() {
            fmt.Print("Enter a number: ")
            var input float64
            fmt.Scanf("%f", &input)

            if input != 3 {

            output := input * 0.3048
            fmt.Println(output)
} else {
            con := 3.0
            output := con * 0.3048
            fmt.Println(output)
}
}
```


## 2.

```
package main
import "fmt"
func main() {
mas := []int{48,2, 96,86,3,68,57,82,63,70,37,34,83,27,19,97,9,17,1}
n := 0
for i, tek := range mas {
if (i == 0) {
n = tek
} else {
if (tek < n){
 n = tek
}
}
}
fmt.Println(n)
}
```

## 3.

```
package main
import "fmt"
   func main() {
        for i := 1; i <= 100; i++ {
        if (i%3) == 0 {
        fmt.Print(i," ")
}
}
}
```
