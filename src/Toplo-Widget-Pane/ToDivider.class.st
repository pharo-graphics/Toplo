"
I am a thin bar that the user drags. I turn the drag into requests and events that tell how far it went, and leave what it means to my subclasses and to my clients: `ToPaneDivider` resizes the two elements it separates, `ToTableDivider` resizes the columns of a table.

`thickness:` sets my breadth. My orientation is the one of the bar: a horizontal divider fills the width of its parent and is dragged up and down.

## Examples

```
ToDivider instanceDefault
```

## Design Rationale

- Dragging is negotiated: before each step, my event handler dispatches a request (`ToDividerStartDragRequestEvent`, `ToDividerDragRequestEvent`) that any listener can deny, then the matching event (`ToDividerStartDragEvent`, `ToDividerDragEvent`, `ToDividerEndDragEvent`). A client can refuse a move without subclassing me.
- The drag only moves me along one axis, so the delta of my events has a zero coordinate.
- I am ignored by the layout of my parent, since my position comes from the drag.

## Usage

1. Nothing in Toplo creates a plain divider: `ToPane>>addDividerBetween:and:` creates `ToPaneDivider`, and tables create `ToTableDivider`.
2. `initialize` adds a `ToDividerEventHandler`, which translates the Bloc drag events.
3. Clients listen to the divider events, or subclasses add their own event handler.

I am a mutable element and stay in the same parent.
"
Class {
	#name : #ToDivider,
	#superclass : #ToElement,
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#instVars : [
		'thickness'
	],
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #instances }
ToDivider class >> instanceDefault [

	<sampleInstance>
	^ self new
]

{ #category : #configuration }
ToDivider >> applyConfiguration [ 

	super applyConfiguration.
	self isHorizontal
		ifTrue: [
				self hMatchParent.
				self constraints vertical exact: self thickness ]
		ifFalse: [
				self vMatchParent.
				self constraints horizontal exact: self thickness ].
	self requestNewSkin
]

{ #category : #initialization }
ToDivider >> defaultEventHandler [ 

	^ ToDividerEventHandler new
]

{ #category : #initialization }
ToDivider >> defaultLayout [

	^ BlLinearLayout new 
]

{ #category : #initialization }
ToDivider >> defaultThickness [

	^ 3
]

{ #category : #initialization }
ToDivider >> initialize [

	super initialize.
	self constraintsDo: [ :c | c ignoreByLayout ].
	self addEventHandler: self defaultEventHandler 
]

{ #category : #skin }
ToDivider >> newRawSkin [

	^ ToDividerSkin new
]

{ #category : #accessing }
ToDivider >> thickness [

	^ thickness ifNil: [ thickness := self defaultThickness ]
]

{ #category : #accessing }
ToDivider >> thickness: aNumber [

	thickness := aNumber.
	self requestConfiguration
]
