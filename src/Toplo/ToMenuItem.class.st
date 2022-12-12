Class {
	#name : #ToMenuItem,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithTooltip + TToClickableWidget',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait + TToClickableWidget classTrait',
	#instVars : [
		'parentMenuWindow'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #initialization }
ToMenuItem >> addedInMenu: aMenu [
	
	self privateParentMenuWindow: aMenu menuWindow.
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
	

]

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

]

{ #category : #window }
ToMenuItem >> parentMenuWindow [

	^ parentMenuWindow 
]

{ #category : #'private - accessing' }
ToMenuItem >> privateParentMenuWindow: aWindow [

	parentMenuWindow := aWindow
]

{ #category : #initialization }
ToMenuItem >> removedFromMenu: aMenu [
	
	self privateParentMenuWindow: nil
]
