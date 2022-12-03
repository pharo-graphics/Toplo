Class {
	#name : #ToCheckboxModel,
	#superclass : #ToButtonModel,
	#category : #'Toplo-View Models'
}

{ #category : #'api - checkbox' }
ToCheckboxModel >> check [

	self checked: true
]

{ #category : #'api - checkbox' }
ToCheckboxModel >> checked: aBooleanOrNil [

	self widgetDo: [ :widget | widget checked: aBooleanOrNil ]
]

{ #category : #'private - accessing - widget' }
ToCheckboxModel >> privateWidgetClass [

	^ ToCheckbox
]

{ #category : #'api - checkbox' }
ToCheckboxModel >> uncheck [

	self checked: false
]

{ #category : #'api - checkbox' }
ToCheckboxModel >> whenCheckedDo: aBlock [

	self widgetDo: [ :widget | widget whenCheckedDo: aBlock ]
]

{ #category : #'api - checkbox' }
ToCheckboxModel >> whenInderterminateDo: aBlock [

	self widgetDo: [ :widget | widget whenInderterminateDo: aBlock ]
]

{ #category : #'api - checkbox' }
ToCheckboxModel >> whenUncheckedDo: aBlock [

	self widgetDo: [ :widget | widget whenUncheckedDo: aBlock ]
]

{ #category : #'api - checked change hook' }
ToCheckboxModel >> whenWithIndeterminateChangedDo: aBlock [

	self widgetDo: [ :widget | widget whenWithIndeterminateChangedDo: aBlock ]
]

{ #category : #initialization }
ToCheckboxModel >> withIndeterminate [

	self widgetDo: [ :widget | widget withIndeterminate ]
]

{ #category : #initialization }
ToCheckboxModel >> withoutIndeterminate [

	self widgetDo: [ :widget | widget withoutIndeterminate ]
]
