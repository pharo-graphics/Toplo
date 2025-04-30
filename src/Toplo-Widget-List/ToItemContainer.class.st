Class {
	#name : #ToItemContainer,
	#superclass : #ToElement,
	#traits : 'TToShrinkable',
	#classTraits : 'TToShrinkable classTrait',
	#instVars : [
		'item'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToItemContainer >> initialize [ 

	super initialize.
	self addShrinkFeedbackLayer 
]

{ #category : #accessing }
ToItemContainer >> item [

	^ item
]

{ #category : #accessing }
ToItemContainer >> item: anElement [

	item = anElement ifTrue: [ ^ self ].
	item ifNotNil: [ item removeFromParent ].
	item := anElement.
	item ifNil: [ ^ self ].
	item removeFromParent.
	self addChild: item at: 1.
	self requestNewSkin 
]
