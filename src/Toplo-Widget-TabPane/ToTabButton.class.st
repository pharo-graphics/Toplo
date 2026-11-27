"
I am the tab of a `ToTabPaneElement`: a tab item that builds and keeps the pane shown in the body when it is selected.

`paneBuilder:` fills the pane; it receives the pane, me and my holder. `paneFactory:` creates the pane, a `ToPane` by default. `paneDestroyer:` and `destroyPaneWhenDeselected:` say what to do with it when the tab is left.

## Examples

```
ToTabPaneElement exampleTabs
```

## Design Rationale

- Creating and filling the pane are separate blocks: the factory chooses the kind of pane, the builder its content, so either can change without the other.
- By default I keep my pane, and it comes back as it was. With `destroyPaneWhenDeselected: true`, the pane is dropped and built again the next time, and `paneDestroyer` can release what it used.

## Usage

`ToTabPaneGroupElement>>defaultTabItemFactory` creates me when a client adds tab data to a tab pane; a client can also create me and send `addItem:`. `ToTabGroupInTabPaneEventHandler` asks me for the pane and sets `bodyPane`.

## Implementation Notes

- `paneDestroyer` does nothing as long as `destroyPaneWhenDeselected` is false, even when the tab is removed.
"
Class {
	#name : #ToTabButton,
	#superclass : #ToTabItemElement,
	#instVars : [
		'paneBuilder',
		'paneDestroyer',
		'bodyPane',
		'destroyPaneWhenDeselected',
		'paneFactory'
	],
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #accessing }
ToTabButton >> bodyPane [

	^ bodyPane
]

{ #category : #accessing }
ToTabButton >> bodyPane: anElement [

	bodyPane := anElement
]

{ #category : #accessing }
ToTabButton >> destroyPaneWhenDeselected [

	^ destroyPaneWhenDeselected
]

{ #category : #accessing }
ToTabButton >> destroyPaneWhenDeselected: aBoolean [

	destroyPaneWhenDeselected := aBoolean
]

{ #category : #initialization }
ToTabButton >> initialize [ 

	super initialize.
	destroyPaneWhenDeselected := false.
	paneBuilder := [ :pane :button :holder | ].
	paneFactory := [ ToPane new ].
	paneDestroyer := [ :theBodyPane :theTabButton :theHolder]
]

{ #category : #skin }
ToTabButton >> newRawSkin [ 

	^ ToTabButtonSkin new
]

{ #category : #accessing }
ToTabButton >> paneBuilder [

	^ paneBuilder
]

{ #category : #accessing }
ToTabButton >> paneBuilder: aValuable [

	"aValuable takes the pane to build, the tab button and its holder as arguments "
	paneBuilder := aValuable
]

{ #category : #accessing }
ToTabButton >> paneDestroyer [

	^ paneDestroyer
]

{ #category : #accessing }
ToTabButton >> paneDestroyer: aValuable [

	"aValuable takes the pane to build, the tab button and its holder as arguments "
	paneDestroyer := aValuable
]

{ #category : #accessing }
ToTabButton >> paneFactory [

	^ paneFactory
]

{ #category : #accessing }
ToTabButton >> paneFactory: aValuable [

	paneFactory := aValuable
]
