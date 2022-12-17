Class {
	#name : #ToElement,
	#superclass : #BlElement,
	#traits : 'TOBlLayoutResizable + TToDressableWidget',
	#classTraits : 'TOBlLayoutResizable classTrait + TToDressableWidget classTrait',
	#category : #'Toplo-Core'
}

{ #category : #'root world' }
ToElement >> openInInnerWindow [

	| frame |
	frame := ToInnerWindow new.
	frame addChild: self.
	frame openInWorld
]

{ #category : #'root world' }
ToElement >> openInWorld [

	| world |
	world := ToManager world.
	world isOpened ifFalse: [ world show ].
	world root addChild: self
]
