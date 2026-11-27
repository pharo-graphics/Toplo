"
I am a pane with tabs: a header that holds one button per tab, and a body that shows the pane of the selected tab. I let a UI put several panes in the same place and show one at a time.

`itemBuilder:` says how to build a tab from a data object, and `addTabItemData:` adds a tab for one. `paneBuilder:`, sent to the `ToTabButton` the builder receives, says how to fill the body. `header`, `tabGroup` and `body` answer my parts.

## Examples

```
ToTabPaneElement exampleTabs.
ToTabPaneElement exampleHeaderOnTheLeft.
ToTabPaneElement exampleManyTabs.
ToTabPaneElement exampleRemovableTabs.
```

## Design Rationale

- A tab is an item of a checkable list: the selected tab is the checked item, and I use `TToItemListUser`, so the list protocol (`items`, `addItem:`, `removeItem:`, `selecter`, …) works on me.
- The header and the tab group are separate. `ToTabPaneHeaderElement` places the tab group among extra elements, `ToTabGroupElement` manages tabs and can be used without any body.
- The pane of a tab is built lazily, the first time the tab is selected, and kept by its button. A tab nobody opens costs nothing.
- My orientation is the one of the header and the body together: I am horizontal (header on the left) by default, and `vertical: true` puts the header at the top. `atStartSide: false` puts it on the other side of the body.
- With `isFlowable: false` the tabs stay on one line and those that do not fit go into a menu. Otherwise they wrap on several lines.

## Usage

1. A client creates me, gives me an orientation and an `itemBuilder:`, and adds tabs with `addTabItemData:`, or adds `ToTabButton`s built by itself with `addItem:`.
2. No tab is selected until the user clicks one or a client checks one, so the body is empty at first. When the selected tab is removed, the next one is selected (`ToTabListInTabGroupEventHandler`).
3. `ToTabGroupInTabPaneEventHandler` shows the pane of the selected tab in my body. It forwards the list events to me, so clients can listen to me.

I am mutable: tabs, orientation and header options can change once I am open.

## Implementation Notes

- `destroyPaneWhenDeselected:` sets the option of the tabs I have now, not of those added later.
- Going back to a tab whose pane is kept does not forward the `ToListPrimarySelectionChangedEvent` to me. This is a known issue.
"
Class {
	#name : #ToTabPaneElement,
	#superclass : #ToPane,
	#traits : 'TToItemListUser',
	#classTraits : 'TToItemListUser classTrait',
	#instVars : [
		'bodyContainer',
		'headerContainer'
	],
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #'private - demo' }
ToTabPaneElement class >> demoTabPaneWithLabels: aCollection [
	"Answer a tab pane with its header at the top and one tab per label. Each tab shows its label in its body."

	| pane |
	pane := self vertical matchParent.
	pane isFlowable: false.
	pane itemBuilder: [ :button :label |
		button
			labelText: label;
			paneBuilder: [ :body | body addChild: (ToLabel text: 'Body of ' , label) ] ].
	aCollection do: [ :label | pane addTabItemData: label ].
	^ pane
]

{ #category : #examples }
ToTabPaneElement class >> exampleHeaderOnTheLeft [
	"The same tabs, stacked on the left of the body."

	<example>
	^ self instanceWithHeaderOnTheLeft openInSpace
]

{ #category : #examples }
ToTabPaneElement class >> exampleManyTabs [
	"Forty tabs: those that do not fit are in the menu at the end of the header."

	<example>
	^ self instanceWithManyTabs openInSpace
]

{ #category : #examples }
ToTabPaneElement class >> exampleRemovableTabs [
	"Tabs with a button to close them, shown when the pointer is over a tab, and a button that adds a tab."

	<example>
	^ self instanceWithRemovableTabs openInSpace
]

{ #category : #examples }
ToTabPaneElement class >> exampleTabs [
	"Three tabs over a body that shows the selected one."

	<example>
	^ self instanceWithTabs openInSpace
]

{ #category : #instances }
ToTabPaneElement class >> instanceWithHeaderOnTheLeft [

	<sampleInstance>
	^ self instanceWithTabs
		  horizontal: true;
		  yourself
]

{ #category : #instances }
ToTabPaneElement class >> instanceWithManyTabs [
	"Answer a tab pane with more tabs than its width shows: the others are in a menu."

	<sampleInstance>
	^ (self demoTabPaneWithLabels: ((1 to: 40) collect: [ :index | 'Tab {1}' format: { index } ]))
		  isScrollable: true;
		  yourself
]

{ #category : #instances }
ToTabPaneElement class >> instanceWithRemovableTabs [
	"Answer a tab pane whose tabs the user can close, and add with a button."

	<sampleInstance>
	| pane |
	pane := self instanceWithTabs.
	pane items do: [ :item | item removable: true ].
	pane addTabItemDataFactory: [ 'New tab' ].
	pane showAddTabItemButton: true.
	^ pane
]

{ #category : #instances }
ToTabPaneElement class >> instanceWithTabs [

	<sampleInstance>
	| pane |
	pane := self demoTabPaneWithLabels: #( 'Daily' 'Weekly' 'Monthly' ).
	pane items first checked: true.
	^ pane
]

{ #category : #adding }
ToTabPaneElement >> addTabItemData: aData [

	self tabGroup addTabItemData: aData
]

{ #category : #accessing }
ToTabPaneElement >> addTabItemDataFactory: aValuable [

	self tabGroup addTabItemDataFactory: aValuable
]

{ #category : #accessing }
ToTabPaneElement >> alignEnd [

	headerContainer alignEnd
]

{ #category : #accessing }
ToTabPaneElement >> alignMiddle [

	headerContainer alignMiddle
]

{ #category : #accessing }
ToTabPaneElement >> alignStart [

	headerContainer alignStart
]

{ #category : #configuration }
ToTabPaneElement >> applyConfiguration [

	super applyConfiguration.

	self tabGroup horizontal: self isHorizontal not.
	self atStartSide
		ifTrue: [ self beStartToEnd ]
		ifFalse: [ self beEndToStart ].
	self isHorizontal
		ifTrue: [
				self header
					beVertical;
					vMatchParent;
					hFitContent ]
		ifFalse: [
				self header
					beHorizontal;
					hMatchParent;
					vFitContent ]
]

{ #category : #accessing }
ToTabPaneElement >> atStartSide [

	^ self tabGroup atStartSide
]

{ #category : #accessing }
ToTabPaneElement >> atStartSide: aBoolean [

	self tabGroup atStartSide: aBoolean.
	self requestConfiguration.
]

{ #category : #accessing }
ToTabPaneElement >> body [ 

	^ bodyContainer 
]

{ #category : #accessing }
ToTabPaneElement >> compactHeaderLayoutMode: aBoolean [

	self header compactLayoutMode: aBoolean.
	self requestConfiguration 
]

{ #category : #accessing }
ToTabPaneElement >> destroyPaneWhenDeselected: aBoolean [

	self items do: [ :tabButton |
		tabButton destroyPaneWhenDeselected: aBoolean ]
]

{ #category : #accessing }
ToTabPaneElement >> header [ 

	^ headerContainer 
]

{ #category : #accessing }
ToTabPaneElement >> headerAlignment [

	^ headerContainer alignment
]

{ #category : #accessing }
ToTabPaneElement >> headerAlignment: anElementAlignment [ 

	headerContainer alignment: anElementAlignment 
]

{ #category : #accessing }
ToTabPaneElement >> hidePartlyVisibleNodes: aBoolean [

	self tabGroup hidePartlyVisibleNodes: aBoolean
]

{ #category : #initialization }
ToTabPaneElement >> initialize [

	super initialize.

	headerContainer := ToTabPaneHeaderElement new.
	bodyContainer := BlElement new
		                 id: #body;
		                 yourself.
	bodyContainer constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent ].

	self addChildren: {
			headerContainer.
			bodyContainer }.
	self tabGroup addEventHandler: (ToTabGroupInTabPaneEventHandler new
			 tabPane: self;
			 yourself).
]

{ #category : #accessing }
ToTabPaneElement >> isAlignEnd [

	^ headerContainer isAlignEnd
]

{ #category : #accessing }
ToTabPaneElement >> isAlignMiddle [

	^ headerContainer isAlignMiddle
]

{ #category : #accessing }
ToTabPaneElement >> isAlignStart [

	^ headerContainer isAlignStart
]

{ #category : #accessing }
ToTabPaneElement >> itemBuilder: aValuable [
	" aValuable takes the new TabItemElement, the data and the holder of the item as arguments "
	
	self tabGroup itemBuilder: aValuable
]

{ #category : #'t - item list user - accessing' }
ToTabPaneElement >> itemList [

	^ self tabGroup itemList
]

{ #category : #accessing }
ToTabPaneElement >> noAlignment [

	headerContainer noAlignment
]

{ #category : #accessing }
ToTabPaneElement >> preservePane [
	self deprecated: 'Use ToTabButton>>#paneDestroyer: to set a destroyer to a particular button'.

	^ false
]

{ #category : #'hooks - layout' }
ToTabPaneElement >> requestLayoutModeCheck [

	headerContainer requestLayoutModeCheck
]

{ #category : #accessing }
ToTabPaneElement >> showAddTabItemButton [

	^ self tabGroup showAddTabItemButton
]

{ #category : #accessing }
ToTabPaneElement >> showAddTabItemButton: aBoolean [

	self tabGroup showAddTabItemButton: aBoolean
]

{ #category : #accessing }
ToTabPaneElement >> tabGroup [ 

	^ headerContainer tabGroup 
]

{ #category : #accessing }
ToTabPaneElement >> tabGroupDynamicLayoutMode: aBoolean [

	self
		deprecated: 'Use compactHeaderLayoutMode: instead'
		transformWith: '`@rcvr tabGroupDynamicLayoutMode: `@arg'
			-> '`@rcvr compactHeaderLayoutMode: `@arg'.
	self compactHeaderLayoutMode: aBoolean
]
