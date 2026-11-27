"
I am meant to be a pane attached to the edge of another element, on the left by default (`defaultPlacement` answers `ToAnchoredAtLeft`).

I am unfinished: my skin fills me with red, and `attachToElement:` only makes the layout ignore me.

## Examples

```
ToEdgePane instanceDefault
```

## Usage

Nothing in Toplo creates me yet. I inherit the anchoring of `ToBaseFloatElement` and I am oriented (`TToOrientable`), so a client would add me to an element and give me an orientation.

## Implementation Notes

- `newInnerElement` is not used: only `ToFloatElement` sends it, and I do not inherit from it.
"
Class {
	#name : #ToEdgePane,
	#superclass : #ToBaseFloatElement,
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #instances }
ToEdgePane class >> instanceDefault [

	<sampleInstance>
	^ self new
]

{ #category : #'attaching  / detaching' }
ToEdgePane >> attachToElement: anElement [

	self constraintsDo: [ :c | c ignoreByLayout ]
]

{ #category : #initialization }
ToEdgePane >> defaultLayout [ 

	^ BlLinearLayout new
]

{ #category : #initialization }
ToEdgePane >> defaultPlacement [ 

	^ ToAnchoredAtLeft new
]

{ #category : #initialization }
ToEdgePane >> initialize [

	super initialize.
	self vMatchParent
]

{ #category : #initialization }
ToEdgePane >> newInnerElement [

	^ ToPane new
]

{ #category : #'instance creation' }
ToEdgePane >> newRawSkin [ 

	^ ToEdgePaneSkin new
]
