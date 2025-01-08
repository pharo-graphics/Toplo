Class {
	#name : #ToItemElement,
	#superclass : #ToElement,
	#traits : 'TToItem',
	#classTraits : 'TToItem classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToItemElement >> defaultLayout [

	^ BlLinearLayout vertical
]

{ #category : #accessing }
ToItemElement >> disabled: aBoolean [

	self parentItemListHolder
		ifNil: [ self presetDisabledWith: aBoolean ]
		ifNotNil: [ :l |
			aBoolean
				ifTrue: [ l disabledItem: self ]
				ifFalse: [ l enabledItem: self ] ].
	super disabled: aBoolean
]

{ #category : #accessing }
ToItemElement >> hidden: aBoolean [

	self parentItemListHolder
		ifNil: [ self presetHiddenWith: aBoolean ]
		ifNotNil: [ :l |
			aBoolean
				ifTrue: [ l hiddenItem: self ]
				ifFalse: [ l visibleItem: self ] ]
]

{ #category : #accessing }
ToItemElement >> unselectable: aBoolean [

	self parentItemListHolder
		ifNil: [ self presetUnselectableWith: aBoolean ]
		ifNotNil: [ :l |
			aBoolean
				ifTrue: [ l unselectableItem: self ]
				ifFalse: [ l selectableItem: self ] ]
]
