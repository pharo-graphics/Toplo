Class {
	#name : #ToMenuItem,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToWidgetWithTooltip + TToClickableWidget',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait + TToClickableWidget classTrait',
	#instVars : [
		'menuWindow'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #initialization }
ToMenuItem >> addedInMenu: aMenu [
	
	self privateMenuWindow: aMenu menuWindow.
	

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
ToMenuItem >> menuWindow [

	^ menuWindow 
]

{ #category : #'private - accessing' }
ToMenuItem >> privateMenuWindow: aWindow [

	menuWindow := aWindow
]
