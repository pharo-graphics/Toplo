Class {
	#name : #ToAdditionalSelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#instVars : [
		'eventClass'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #instanceCreation }
ToAdditionalSelectionModelOperator class >> on: anElement withEventClass: anEventClass [

	^ self new
		  eventClass: anEventClass;
		  onInstalledIn: anElement;
		  yourself
]

{ #category : #accessing }
ToAdditionalSelectionModelOperator >> eventClass [

	^ eventClass
]

{ #category : #accessing }
ToAdditionalSelectionModelOperator >> eventClass: anEventClass [

	eventClass := anEventClass
]

{ #category : #'private command application' }
ToAdditionalSelectionModelOperator >> notifySelectionChangedAfter: aCommand in: aTarget [

	aCommand selectionChanged ifFalse: [ ^ self ].

	aTarget dispatchEvent: (self eventClass new
			 selectionModel: aCommand selectionModel;
			 yourself)
]
