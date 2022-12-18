Class {
	#name : #ToLabelModel,
	#superclass : #ToViewModel,
	#classTraits : 'TObservable classTrait',
	#category : #'Toplo-View Models'
}

{ #category : #editability }
ToLabelModel >> beEditable [

	self widgetDo: [ :widget | widget beEditable ]
]

{ #category : #initialization }
ToLabelModel >> beMonoLine [

	self widgetDo: [:widget | self lineMode: ToLabelMonoLineMode new ]
]

{ #category : #initialization }
ToLabelModel >> beMultiLine [

	self widgetDo: [:widget | self lineMode: ToLabelMultiLineMode new ]
]

{ #category : #editability }
ToLabelModel >> beReadOnly [ 

	self widgetDo: [ :widget | widget beReadOnly ]
]

{ #category : #accessing }
ToLabelModel >> isEditable: aBoolean [

	self widgetDo: [:label | label isEditable: aBoolean ]
]

{ #category : #accessing }
ToLabelModel >> lineMode: aLineMode [

	self widgetDo: [ :label | label lineMode: aLineMode ]
]

{ #category : #'private - accessing - widget' }
ToLabelModel >> privateWidgetClass [

	^ ToLabel
]

{ #category : #accessing }
ToLabelModel >> text: aBlTextOrString [


	self widgetDo: [ :label | label text: aBlTextOrString ]
]

{ #category : #'api - change hook' }
ToLabelModel >> whenEditableChangedDo: aBlock [

	self widgetDo: [ :widget | widget whenEditableChangedDo: aBlock ]
]

{ #category : #'api - change hook' }
ToLabelModel >> whenLineModeChangedDo: aBlock [

	self widgetDo: [ :widget | widget whenLineModeChangedDo: aBlock ]
]

{ #category : #'api - change hook' }
ToLabelModel >> whenTextReplacedDo: aBlock [

	self widgetDo: [ :widget | widget whenTextReplacedDo: aBlock ]
]
