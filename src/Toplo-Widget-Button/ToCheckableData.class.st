Class {
	#name : #ToCheckableData,
	#superclass : #Object,
	#instVars : [
		'group',
		'checked',
		'withIndeterminate',
		'eventHandler'
	],
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #accessing }
ToCheckableData >> checked [

	^ checked ifNil: [ checked := false ]
]

{ #category : #accessing }
ToCheckableData >> checked: aBoolean [

	checked := aBoolean
]

{ #category : #accessing }
ToCheckableData >> eventHandler [

	^ eventHandler
]

{ #category : #accessing }
ToCheckableData >> eventHandler: anEventHandler [

	eventHandler := anEventHandler
]

{ #category : #accessing }
ToCheckableData >> group [

	^ group
]

{ #category : #accessing }
ToCheckableData >> group: aGroup [

	group := aGroup
]

{ #category : #accessing }
ToCheckableData >> withIndeterminate [

	^ withIndeterminate ifNil: [ withIndeterminate := false  ]
]

{ #category : #accessing }
ToCheckableData >> withIndeterminate: aBoolean [

	withIndeterminate := aBoolean
]
