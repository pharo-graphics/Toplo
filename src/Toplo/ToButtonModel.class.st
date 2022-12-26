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
ToButtonModel >> beIconFirst [

	self widgetDo: [ :widget | widget beIconFirst ]
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
ToButtonModel >> horizontal: aBoolean [

	self widgetDo: [ :widget | widget horizontal: aBoolean ]
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
ToButtonModel >> whenIconImageReplacedDo: aBlock [

	self widgetDo: [ :widget | widget whenIconImageReplacedDo: aBlock ]
]

{ #category : #'as yet unclassified' }
ToButtonModel >> whenLabelTextReplacedDo: aBlock [

	self widgetDo: [ :widget | widget whenLabelTextReplacedDo: aBlock]
]
