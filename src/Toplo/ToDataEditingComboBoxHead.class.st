Class {
	#name : #ToDataEditingComboBoxHead,
	#superclass : #ToEditableComboBoxHead,
	#category : #'Toplo-Widget-ComboBox'
}

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
ToDataEditingComboBoxHead >> initialize [ 

	super initialize.

]

{ #category : #'data editing' }
ToDataEditingComboBoxHead >> whenCancelRequested: cancelRequested in: aComboBox [

	aComboBox selectedIndex isZero ifTrue: [
		self textField text: ''.
		^ self noDataSelected ].
	self selectData: aComboBox selectedData in: aComboBox.
	aComboBox listElement dispatchEvent: (ToDataFilterRequestEvent new pattern: self textField text asString)
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
