Class {
	#name : #ToButtonModel,
	#superclass : #ToGeneralButtonModel,
	#category : #'Toplo-Widget-Button-Model'
}

{ #category : #accessing }
ToButtonModel >> beHorizontal [

	self horizontal: true
]

{ #category : #accessing }
ToButtonModel >> beLabelFirst [ 

	self widgetDo: [ :widget | widget beLabelFirst ]
]

{ #category : #accessing }
ToButtonModel >> beVertical [

	self horizontal: false
]

{ #category : #accessing }
ToButtonModel >> horizontal: aBoolean [

	self widgetDo: [ :widget | widget horizontal: aBoolean ] 
]

{ #category : #accessing }
ToButtonModel >> icon: anElement [

	self widgetDo: [ :widget | widget icon: anElement ] 
]

{ #category : #accessing }
ToButtonModel >> iconImage: anElement [

	self widgetDo: [ :widget | widget icon innerImage: anElement ]
]

{ #category : #accessing }
ToButtonModel >> label: anElement [

	self widgetDo: [ :widget | widget label: anElement ] 
]

{ #category : #accessing }
ToButtonModel >> labelText: aText [

	self widgetDo: [ :widget | widget labelText: aText ] 
]

{ #category : #'private - accessing - widget' }
ToButtonModel >> privateWidgetClass [

	^ ToButton
]
