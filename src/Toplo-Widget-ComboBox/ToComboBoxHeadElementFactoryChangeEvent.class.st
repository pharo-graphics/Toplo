Class {
	#name : #ToComboBoxHeadElementFactoryChangeEvent,
	#superclass : #ToComboBoxEvent,
	#instVars : [
		'factory'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #accessing }
ToComboBoxHeadElementFactoryChangeEvent >> factory [

	^ factory
]

{ #category : #accessing }
ToComboBoxHeadElementFactoryChangeEvent >> factory: aValuable [

	factory := aValuable
]
