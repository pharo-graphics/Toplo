Class {
	#name : #ToMenuItem,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToClickableWidget + TToWidgetWithTooltip',
	#classTraits : 'TToWidget classTrait + TToClickableWidget classTrait + TToWidgetWithTooltip classTrait',
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - initialization dresser' }
ToMenuItem >> defaultDresser [

	^ ToMenuItemDresser new
]

{ #category : #initialization }
ToMenuItem >> initialize [

	self class initializeSlots: self.
	super initialize.
	
	self layout: BlLinearLayout horizontal.
	self fitContent.
	self initializeClickBehavior.
	self initializeDresser 
]
