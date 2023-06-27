Class {
	#name : #ToMenuItem,
	#superclass : #ToAbstractMenuItem,
	#traits : 'TToWidget + TToWidgetWithTooltip + TToClickable + TToEnableable',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait + TToClickable classTrait + TToEnableable classTrait',
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - click behavior' }
ToMenuItem >> client [

	^ self parentMenu client
]

{ #category : #initialization }
ToMenuItem >> initialize [

	super initialize.
	self fitContent.

]

{ #category : #'t - click behavior' }
ToMenuItem >> whenClickedDo: aBlock [
	"Inform that the widget has been clicked (on a mouse-up for a menu item)"

	self when: BlMouseUpEvent do: [ :event | 
		aBlock
			cull: event
			cull: self client
			cull: (self clickTargetFromEvent: event) ].

]
