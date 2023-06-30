Class {
	#name : #ToMenuBarAutoOpenDresser,
	#superclass : #ToDresser,
	#instVars : [
		'overHandler',
		'menuBarDresser',
		'mouseEventOutsideHandler'
	],
	#category : #'Toplo-Widget-MenuBar'
}

{ #category : #'api - accessing' }
ToMenuBarAutoOpenDresser >> mouseUpOutside: anEvent in: aMenuBar [ 

	anEvent originalEvent currentTarget ifNotNil: [ :t |
		(t hasInParentChain: aMenuBar) ifTrue: [ ^ self ] ].
	self removeAutoOpenDresserIn: aMenuBar
]
