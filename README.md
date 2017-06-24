# CustomStaticTableHeadersDemo

iOS demo of customizing Static TableView Headers including interactive buttons.

## Installation

Clone or download this repository and run. Developed and tested in Xcode 8.2.1 and iOS 10.2.

## Description

There are two main options for customizing static headers for TableViews:

- tableView(_ tableView: UITableView, viewForHeaderInSection section: Int)
- tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)

willDisplayHeaderView on the other hand provides the default view and allows for modification of it. Simple appearance modifications are fairly straight forward. Adding interactive features such as buttons is a bit more complicated, and is the focus of this demo.

viewForHeaderInSection returns the view for the header, which can be loaded from a nib or created entirely in code. One disadvantage of this is that it gives no access to the default appearance of headers, and Apple only provides access to one default (UIColor.groupTableViewBackground). A good example of using a nib file can be found at http://samwize.com/2015/11/06/guide-to-customizing-uitableview-section-header-footer/

### Dynamic Tables

Most of what this demo does can also be accomplished using dynamic tables and prototyle cells. This allows a great deal of flexibility, but it also requires a data source setup, and sometimes a static table is a better choice for straightforward needs. A good demo of this can be found at https://www.youtube.com/watch?v=6CX2kJExI_M.

## Limitations & Next Steps

Currently, this project demonstraits showing/hiding rows and toggling row checkmarks from an interactive section headers. It does currently not store values for the checkmarks so if cells are reused there may be some odd behavoir when scrolling. 

There are also a few additions which would add a bit of polish which aren't included:

1. Add a disclosure chevron next to the section header. This could act as the button to show/hide rows, but also would provide some feedback on this functionality to the user. One description of how to accomplish this using the existing system appearance can be found at https://stackoverflow.com/questions/13836606/use-table-view-disclosure-indicator-style-for-uibutton-ios.

2. Update selectButton title based on current status of checkmarks set individually. This is relativly straightforward by using didSelectRowAt.

## History

In trying to customize static TableView headers, I looked through many online posts to find the answer. Along the way I found no clear, consice examples to accomplish all the goals. Additionally, I found several prominent posts with incorrect information or examples. As a typical programmer (i.e. lazy) I rely the help ofothers frequently, so I wanted to give something back.

## Credits

This demo was build up on top of the work of several others. Below is an incomplete list:

- [Customizing Appearance wtih Static TableViews](https://stackoverflow.com/questions/31680941/how-to-customise-header-section-in-static-cell)
- [Show/Hide rows](https://stackoverflow.com/questions/8260267/uitableview-set-to-static-cells-is-it-possible-to-hide-some-of-the-cells-progra)
- [Custom Headers with Dynamic TableViews](https://www.youtube.com/watch?v=6CX2kJExI_M)


## License

