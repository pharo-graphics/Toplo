Class {
	#name : #ToMenuItem,
	#superclass : #ToAbstractMenuItem,
	#traits : 'TToWidget + TToWidgetWithTooltip + TToClickableWidget',
	#classTraits : 'TToWidget classTrait + TToWidgetWithTooltip classTrait + TToClickableWidget classTrait',
	#category : #'Toplo-Widget-Menu'
}

{ #category : #initialization }
ToMenuItem >> initialize [

	self class initializeSlots: self.
	super initialize.
	self fitContent.

]

{ #category : #initialization }
ToMenuItem >> removedFromMenu: aMenu [
	
	super removedFromMenu: aMenu.
	self privateParentMenu: nil
]
