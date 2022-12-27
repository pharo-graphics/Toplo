Class {
	#name : #ToButtonModel,
	#superclass : #ToGeneralButtonModel,
	#category : #'Toplo-View Models'
}

{ #category : #accessing }
ToButtonModel >> beHorizontal [

	self horizontal: true
]

{ #category : #'api - presentation' }
ToButtonModel >> beLabelFirst [

	self widgetDo: [ :widget | widget beLabelFirst ]
]

{ #category : #accessing }
ToButtonModel >> beVertical [

	self horizontal: false
]

{ #category : #accessing }
ToButtonModel >> element: anElement [

	self widgetDo: [ :widget | widget element: anElement ] 
]

{ #category : #accessing }
ToButtonModel >> horizontal: aBoolean [

	self widgetDo: [ :widget | widget horizontal: aBoolean ] 
]

{ #category : #accessing }
ToButtonModel >> icon: anElement [

	self widgetDo: [ :widget | widget element: anElement ] 
]

{ #category : #accessing }
ToButtonModel >> iconImage: anElement [

	self widgetDo: [ :widget | widget iconImage: anElement ]
]

{ #category : #accessing }
ToButtonModel >> labelText: aText [

	self widgetDo: [ :widget | widget labelText: aText] 
]

{ #category : #'private - accessing - widget' }
ToButtonModel >> privateWidgetClass [

	^ ToButton
]
