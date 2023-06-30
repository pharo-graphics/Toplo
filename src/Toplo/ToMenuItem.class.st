Class {
	#name : #ToMenuItem,
	#superclass : #ToAbstractMenuItem,
	#traits : 'TToWidget + TToWidgetWithTooltip + TToClickable + TToEnableable',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait + TToClickable classTrait + TToEnableable classTrait',
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - click behavior' }
ToMenuItem >> clickEventClass [

	^ BlMouseUpEvent
]

{ #category : #'t - click behavior' }
ToMenuItem >> client [

	^ self parentMenu client
]

{ #category : #initialization }
ToMenuItem >> initialize [

	super initialize.
	self fitContent.

]
