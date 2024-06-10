Class {
	#name : #ToSegment,
	#superclass : #ToBarNode,
	#classTraits : 'TToCheckable classTrait',
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #initialization }
ToSegment >> initialize [

	super initialize.
	self
		addEventFilterOn: BlMouseEvent
		do: [ :event |
		self isSelected ifTrue: [ event consume ] ]
]
