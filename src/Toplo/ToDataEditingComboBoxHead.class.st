Class {
	#name : #ToDataEditingComboBoxHead,
	#superclass : #ToEditableComboBoxHead,
	#instVars : [
		'dataToTextConverter',
		'textToDataConverter'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #accessing }
ToDataEditingComboBoxHead >> dataToTextConverter [

	^ dataToTextConverter
]

{ #category : #accessing }
ToDataEditingComboBoxHead >> dataToTextConverter: aValuable [

	dataToTextConverter := aValuable
]

{ #category : #initialization }
ToDataEditingComboBoxHead >> defaultDataToTextConverter [

		^ [ :d | d ]

]

{ #category : #'t - initialization dresser' }
ToDataEditingComboBoxHead >> defaultDresser [

	^ ToDataEditingComboBoxHeadDresser new
]

{ #category : #initialization }
ToDataEditingComboBoxHead >> defaultTextField [

	^ super defaultTextField
		  withSaveCapability;
		  withEditsFeedbackLayer;
		  yourself
]

{ #category : #initialization }
ToDataEditingComboBoxHead >> defaultTextToDataConverter [

		^ [ :d | d asString ]

]

{ #category : #initialization }
ToDataEditingComboBoxHead >> initialize [ 

	super initialize.
	self dataToTextConverter: self defaultDataToTextConverter.
	self textToDataConverter: self defaultTextToDataConverter.

]

{ #category : #accessing }
ToDataEditingComboBoxHead >> textToDataConverter [

	^ textToDataConverter
]

{ #category : #accessing }
ToDataEditingComboBoxHead >> textToDataConverter: aValuable [

	textToDataConverter := aValuable
]

{ #category : #'data editing' }
ToDataEditingComboBoxHead >> whenCancelRequested: cancelRequested in: aComboBox [
]

{ #category : #'data editing' }
ToDataEditingComboBoxHead >> whenSaveRequested: aSaveRequestedAnnouncement in: aComboBox [

	| data |
	data := self textToDataConverter value: aSaveRequestedAnnouncement client text.
	(aComboBox canInsertData: data) ifTrue: [
		aComboBox insertData: data.
		aSaveRequestedAnnouncement client saveResult: true.
		^ self ].
	aSaveRequestedAnnouncement client saveResult: false
]
