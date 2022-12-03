Class {
	#name : #ToMenuItem,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithTooltip',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait',
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
	
	self initializeDresser 
]
