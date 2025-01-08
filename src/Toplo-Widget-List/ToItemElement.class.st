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

	aBoolean
		ifTrue: [
			self parentItemListHolderDo: [ :l |
				l disableItem: self ] ]
		ifFalse: [
			self parentItemListHolderDo: [ :l |
				l enableItem: self ] ].
	super disabled: aBoolean
]
