Class {
	#name : #ToSelectMode,
	#superclass : #Object,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectMode >> defaultMonoSelectHeaderNodeClass [

	^ ToSingleSelectHeaderNode
]

{ #category : #testing }
ToSelectMode >> isFiltrableMode [

	^ false
]

{ #category : #'api - hooks' }
ToSelectMode >> onInstalledIn: aSelect [

	select := aSelect.

]

{ #category : #'api - hooks' }
ToSelectMode >> onUninstalledIn: aSelect [

	select := nil
]

{ #category : #'api - hooks' }
ToSelectMode >> reInstall [

	| s |
	s := select.
	self onUninstalledIn: s.
	self onInstalledIn: s
]
