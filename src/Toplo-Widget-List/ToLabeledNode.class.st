Class {
	#name : #ToLabeledNode,
	#superclass : #ToNode,
	#traits : 'TToElementWithLabeledIcon',
	#classTraits : 'TToElementWithLabeledIcon classTrait',
	#instVars : [
		'labeledIcon'
	],
	#category : 'Toplo-Widget-List-node'
}

{ #category : #testing }
ToLabeledNode class >> isDeprecated [ 

	^ true
]

{ #category : #initialization }
ToLabeledNode >> initialize [

	self class initializeSlots: self.
	super initialize.
	self withStamp: #button.
	self layout: self defaultLayout.
	labeledIcon := ToLabeledIcon new.
	self addChild: labeledIcon.
	self fitContent
]

{ #category : #'t - element with labeled icon - accessing' }
ToLabeledNode >> labeledIcon [ 

	^ labeledIcon 
]

{ #category : #'t - orientable - accessing' }
ToLabeledNode >> layoutStrategy [

	^ self labeledIcon layout
]

{ #category : #'private-change' }
ToLabeledNode >> privateBeEditable [

	self label ifNotNil: [ :l | l beEditable ]
]

{ #category : #'private-change' }
ToLabeledNode >> privateBeReadOnly [ 

	self label ifNotNil: [ :l | l beReadOnly ]
]
