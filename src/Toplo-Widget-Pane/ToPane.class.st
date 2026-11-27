"
I am a container that lays out its children in a line, horizontally or vertically. I am the basic building block of a window: clients nest panes, and put dividers between children so that the user can resize them.

`horizontal` and `vertical` on my class side create me filling my parent along my orientation and fitting my content across it. `addDividers` puts a `ToPaneDivider` between each pair of consecutive children. `placeholderBuilder:` gives me a layer to show over my content.

## Examples

```
ToPane exampleHorizontalWithDividers.
ToPane exampleVerticalWithDividers.
ToPane exampleWeightedDivider.
ToPane examplePasteUp.
```

## Design Rationale

- Dividers are ordinary children ignored by my layout. They overlap the boundary between two elements instead of taking a place in the line, so adding or removing them does not move the content.
- Resizing is optional and per boundary: `addDividers` covers the common case, `addDividerBetween:and:` puts a single divider where it is needed.
- Orientation, direction, placeholder and free dragging come from traits (`TToOrientable`, `TToDirectional`, `TToElementWithPlaceholder`, `TToPasteUpPane`) because other elements need them without being panes.

## Usage

1. Clients create me with `horizontal`, `vertical` or `new`, and nest me with other panes. `ToElement>>inHorizontalPane` and `ToElement>>inVerticalPane` create me around a single element.
2. They add children, then send `addDividers`. Elements resized by a divider are easiest to use with `matchParent` along my orientation, so that their sizes are weights that follow mine; `ToPaneDivider>>weight:` sets the initial one.
3. My subclasses specialize me: `ToCheckableGroupPane` groups checkables, `ToTabPaneElement` shows tabs.

I am mutable: children, orientation and direction can change after I am open, and my dividers follow the orientation.

## Implementation Notes

- `addDividers` looks at all my children, dividers included. Sending it a second time also puts dividers next to the existing ones: send `removeDividers` first.
- Because dividers are ignored by my layout, `onLayout:context:` lays out the ignored children explicitly.
- `outskirts` is outside, so a border is drawn around my bounds and does not cover my children.
"
Class {
	#name : #ToPane,
	#superclass : #ToElement,
	#traits : 'TToOrientable + TToDirectional + TToPasteUpPane + TToElementWithPlaceholder',
	#classTraits : 'TToOrientable classTrait + TToDirectional classTrait + TToPasteUpPane classTrait + TToElementWithPlaceholder classTrait',
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #'private - demo' }
ToPane class >> demoElementColored: aColor [
	"Answer a translucent element that fills its parent."

	^ ToElement new
		  background: (aColor alpha: 0.3);
		  matchParent;
		  yourself
]

{ #category : #examples }
ToPane class >> exampleHorizontalWithDividers [
	"Three elements side by side, with a draggable divider between each pair."

	<example>
	^ ToPaneDivider instanceInHorizontalPane parent openInSpace
]

{ #category : #examples }
ToPane class >> examplePasteUp [
	"Two squares that can be dragged around freely."

	<example>
	| pane |
	pane := self instanceDefault.
	pane layout: BlBasicLayout new.
	pane initializeAsPasteUp.
	pane addChildren: ({
		 Color blue.
		 Color red } withIndexCollect: [ :color :index |
			 ToElement new
				 background: color;
				 extent: 60 @ 60;
				 position: 80 * index @ 40;
				 yourself ]).
	^ pane openInSpace
]

{ #category : #examples }
ToPane class >> exampleVerticalWithDividers [
	"Three stacked elements, with a draggable divider between each pair."

	<example>
	^ ToPaneDivider instanceInVerticalPane parent openInSpace
]

{ #category : #examples }
ToPane class >> exampleWeightedDivider [
	"Two elements, the first one with a weight set through its divider."

	<example>
	^ ToPaneDivider instanceWeighted parent openInSpace
]

{ #category : #factory }
ToPane class >> horizontal [

	^ self new
		  beHorizontal;
		  vFitContent;
		  hMatchParent;
		  yourself
]

{ #category : #instances }
ToPane class >> instanceDefault [

	<sampleInstance>
	^ self vertical matchParent
]

{ #category : #factory }
ToPane class >> vertical [

	^ self new
		  beVertical;
		  hFitContent;
		  vMatchParent;
		  yourself
]

{ #category : #dividers }
ToPane >> addDividerBetween: aFirstElement and: aSecondElement [

	| divider |
	divider := ToPaneDivider between: aFirstElement and: aSecondElement.
	self addChild: divider.
	^ divider 
]

{ #category : #dividers }
ToPane >> addDividers [

	| lastIdx dividers |
	dividers := OrderedCollection new.
	lastIdx := self children size.
	self children withIndexDo: [ :child :idx |
			idx < lastIdx ifTrue: [
					dividers add:
						(self addDividerBetween: child and: (self children at: idx + 1)) ] ].
	^ dividers
]

{ #category : #initialization }
ToPane >> defaultLayout [

	^ BlLinearLayout new 
]

{ #category : #dividers }
ToPane >> dividers [

	^ self children select: [ :child | child isKindOf: ToPaneDivider ]
]

{ #category : #skin }
ToPane >> installRawStyle [

	super installRawStyle.
	self outskirts: BlOutskirts outside.
	self background: (self valueOfTokenNamed: #'background-color').
	self geometry: (BlRoundedRectangleGeometry cornerRadius:
			 (self valueOfTokenNamed: #'border-radius'))
]

{ #category : #layout }
ToPane >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	self layout layoutIgnored: self context: aBlElementBoundsUpdateContext

]

{ #category : #dividers }
ToPane >> removeDividers [

	self removeChildren: self dividers
]

{ #category : #dividers }
ToPane >> subpanes [

	^ self children select: [ :child | child isKindOf: ToPane ]
]
