Class {
	#name : #ToListItemNode,
	#superclass : #ToListNode,
	#traits : 'TToItemNode',
	#classTraits : 'TToItemNode classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #configuration }
ToListItemNode >> applyWidgetConfiguration [

	| list |
	super applyWidgetConfiguration.
	list := self holder listElement.
	list exactItemWidth ifNotNil: [ :w | self item width: w ].
	list exactItemHeight ifNotNil: [ :h | self item height: h ]
]

{ #category : #initialization }
ToListItemNode >> initialize [

	super initialize.
	self initializeAsItemNode 
]
