Class {
	#name : #ToMenuItem,
	#superclass : #ToAbstractMenuItem,
	#traits : 'TToWidget + TToWidgetWithTooltip + TToClickable',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait + TToClickable classTrait',
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - click behavior' }
ToMenuItem >> client [

	^ self parentMenu client
]

{ #category : #initialization }
ToMenuItem >> initialize [

	self class initializeSlots: self.
	super initialize.
	self fitContent.

]
