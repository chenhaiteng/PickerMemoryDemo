# PickerMemoryDemo
It's a demo project to show SwiftUI Picker memory issue.

The project includes:
1. A wrapper view of Picker named StyledPicker to reduce the effort to wrap Picker for different style. I use this wrapper to test different style picker.
2. EasyMenuPicker -- a menu style picker which use less memory in built-in Picker.
3. Static test data which created from ISO languages list. 

Following tables records the memory usage of Picker for each style:

- iOS

|style| init | expanded/scroll | collapsed | comment|
|---|---|---|---|---|
|automatic| | | | default value, refer to other sytle to estimate memory usage.|
|menu|~114 MB|~107 MB|~102 MB||
|inline|~65 MB|~53 MB|  | Normally wrapped in Form |
|navigationLink|~40 MB|~45 MB|~38 MB| Normally wrapped in NavigationStack |
|palette|~22 MB|~139 MB|~139 MB| Normally wrapped in Menu |
|segmented|~63 MB|~64 MB|  ||
|wheel|~43 MB|~43 MB|  ||

- macOS

|style| init | expanded/scroll | collapsed | comment|
|---|---|---|---|---|
|automatic| | | | default value, refer to other sytle to estimate memory usage.|
|menu|~108 MB|~120 MB|~120 MB|
|inline|~225 MB|~225 MB| | When use it directly, it shows as radio group; when wrapped in Menu, it shows as menu |
|radioGroup|~221 MB|~221 MB| | |
|palette|~22 MB|~139 MB|~139 MB| The memory increase after expand/collapse menu everytime. |
|segmented|~310 MB|~310 MB| ~310 MB |||

- EasyMenuPicker
|init| expanded/scroll | collapsed|
|---|---|---|
|< 1 MB|2~3 MB|~1MB|

