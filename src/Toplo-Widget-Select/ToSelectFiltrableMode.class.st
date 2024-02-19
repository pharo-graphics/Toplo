Class {
	#name : #ToSelectFiltrableMode,
	#superclass : #ToSelectMode,
	#instVars : [
		'filtrableListEventHandler',
		'sieve'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToSelectFiltrableMode >> dataFilter: aValuable [

	sieve dataFilter: aValuable
]

{ #category : #testing }
ToSelectFiltrableMode >> isFiltrableMode [

	^ true
]

{ #category : #'api - hooks' }
ToSelectFiltrableMode >> onInstalledIn: aSelect [

	super onInstalledIn: aSelect.

]

{ #category : #'api - hooks' }
ToSelectFiltrableMode >> onUninstalledIn: aSelect [

	filtrableListEventHandler := nil.
	super onUninstalledIn: aSelect.
]

{ #category : #accessing }
ToSelectFiltrableMode >> sieve [ 

	^ sieve
]
