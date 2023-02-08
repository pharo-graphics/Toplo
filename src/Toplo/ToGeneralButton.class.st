Class {
	#name : #ToGeneralButton,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToClickable + TToWidgetWithTooltip + TToWidgetWithViewModel + TToWidgetWithContextMenu',
	#classTraits : 'TToWidget classTrait + TToClickable classTrait + TToWidgetWithTooltip classTrait + TToWidgetWithViewModel classTrait + TToWidgetWithContextMenu classTrait',
	#instVars : [
		'client'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - click behavior' }
ToGeneralButton >> client [

	^ client
]

{ #category : #accessing }
ToGeneralButton >> client: anObject [

	client := anObject
]

{ #category : #'t - accessing context menu' }
ToGeneralButton >> contextMenu: aMenu [

	self userData at: #contextMenu put: aMenu.
	aMenu client: self client.
	aMenu widget: self
]

{ #category : #initialization }
ToGeneralButton >> initialize [ 

	self class initializeSlots: self.
	super initialize.

]
