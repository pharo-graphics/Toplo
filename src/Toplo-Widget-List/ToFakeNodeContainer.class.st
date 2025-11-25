Class {
	#name : #ToFakeNodeContainer,
	#superclass : #ToNodeContainer,
	#instVars : [
		'startExtent'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #initialization }
ToFakeNodeContainer >> applyConfiguration [

	super applyConfiguration.

	"in case my orientation changes the original size must be stored.
	The original size has to be stored before setting the height or the width to zero.
	see also addFakeNode:"
	self holder listElement isHorizontal
		ifTrue: [
				self extent: 0 @ self startExtent y ]
		ifFalse: [
				self extent: self startExtent x @ 0 ]
]

{ #category : #initialization }
ToFakeNodeContainer >> initialize [

	super initialize.
	self visibility: BlVisibility hidden.
	" The purpose of the extent handler is to make a fake node remains invisible. 
	this is ensured by forcing the height to zero (if the bar is vertical) 
	or the width to zero (if ther bar is horizontal).  "

	self
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ self applyConfiguration ]
]

{ #category : #testing }
ToFakeNodeContainer >> isFake [

	^ true
]

{ #category : #'hooks - layout' }
ToFakeNodeContainer >> onLayoutDone [

	super onLayoutDone.
	startExtent ifNil: [ startExtent := self extent ]
]

{ #category : #accessing }
ToFakeNodeContainer >> startExtent [

	^ startExtent ifNil: [ self extent ]
]
