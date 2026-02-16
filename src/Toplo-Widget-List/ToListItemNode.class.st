Class {
	#name : #ToListItemNode,
	#superclass : #ToBasicListNode,
	#traits : 'TToListItemNode',
	#classTraits : 'TToListItemNode classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #configuration }
ToListItemNode >> applyConfiguration [ 

	super applyConfiguration.
	self item ifNil: [ ^ self ].
	self item applyConfiguration.
	self vFitContent 
]

{ #category : #initialization }
ToListItemNode >> initialize [

	super initialize.
	self layout: BlLinearLayout horizontal.
	self hMatchParent.
	self vFitContent 
]

{ #category : #skin }
ToListItemNode >> newRawSkin [ 

	^ ToItemNodeSkin new 
]
