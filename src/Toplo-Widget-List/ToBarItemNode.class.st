Class {
	#name : #ToBarItemNode,
	#superclass : #ToBarNode,
	#traits : 'TToItemNode',
	#classTraits : 'TToItemNode classTrait',
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #configuration }
ToBarItemNode >> applyWidgetConfiguration [

	| list |
	super applyWidgetConfiguration.
	list := self holder listElement.
	list exactItemWidth ifNotNil: [ :w | self item width: w ].
	list exactItemHeight ifNotNil: [ :h | self item height: h ]
]

{ #category : #initialization }
ToBarItemNode >> initialize [

	super initialize.
	self initializeAsItemNode 
]
