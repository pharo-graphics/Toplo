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

{ #category : #'api - change hook' }
ToButtonModel >> whenIconImageReplacedDo: aBlock [

	self widgetDo: [ :widget | widget whenIconImageReplacedDo: aBlock ]
]

{ #category : #'api - change hook' }
ToButtonModel >> whenLabelTextReplacedDo: aBlock [

	self widgetDo: [ :widget | widget whenLabelTextReplacedDo: aBlock]
]

{ #category : #'api - change hook' }
ToButtonModel >> whenPresentationChangedDo: aBlock [

	"Inform when labelFirst has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new labelFirst
	 - old labelFirst"

	self widgetDo: [ :widget | widget whenPresentationChangedDo: aBlock ]
]
