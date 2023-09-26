Class {
	#name : #ToGeneralButton,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToClickable + TToWidgetWithTooltip + TToWidgetWithViewModel + TToWidgetWithContextMenu + TToShapeableWidget',
	#classTraits : 'TToWidget classTrait + TToClickable classTrait + TToWidgetWithTooltip classTrait + TToWidgetWithViewModel classTrait + TToWidgetWithContextMenu classTrait + TToShapeableWidget classTrait',
	#instVars : [
		'client'
	],
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #'t - clickable - click behavior' }
ToGeneralButton >> client [

	^ client
]

{ #category : #accessing }
ToGeneralButton >> client: anObject [

	client := anObject
]

{ #category : #'t - initialization dresser' }
ToGeneralButton >> defaultDresser [

	^ ToWidgetDresser new
]
