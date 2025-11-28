Class {
	#name : #ToBarFakeNodeContainer,
	#superclass : #ToBarNodeContainer,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #configuration }
ToBarFakeNodeContainer >> applyConfiguration [

	"in case my orientation changes the original size must be stored.
	The original size has to be stored before setting the height or the width to zero.
	see also addFakeNode:"
	super applyConfiguration.

	self holder listElement isHorizontal
		ifTrue: [
				self width: 0 ]
		ifFalse: [
				self height: 0 ].
	
]

{ #category : #initialization }
ToBarFakeNodeContainer >> initialize [

	super initialize.
	self visibility: BlVisibility hidden
]

{ #category : #testing }
ToBarFakeNodeContainer >> isFake [

	^ true
]
