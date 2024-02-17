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

{ #category : #'accessing selection' }
ToSelectFiltrableMode >> deselectIndex: anIndex [

	select listElement selecter deselectIndex: anIndex
]

{ #category : #testing }
ToSelectFiltrableMode >> isFiltrableMode [

	^ true
]

{ #category : #'accessing selection' }
ToSelectFiltrableMode >> onClickAtIndex: anIndex [

	(select listElement selectionModel containsIndex: anIndex)
		ifTrue: [ self deselectIndex: anIndex ]
		ifFalse: [
			select isMultipleSelection ifFalse: [
				select listElement selecter deselectAll ].
			self selectIndex: anIndex ]
]

{ #category : #'api - hooks' }
ToSelectFiltrableMode >> onInstalledIn: aSelect [

	super onInstalledIn: aSelect.

	filtrableListEventHandler := ToSelectFiltrableListEventHandler new
		                             select: select;
		                             yourself.
	select listElement addEventHandler: filtrableListEventHandler.

	sieve := ToListElementSieve new.
	sieve onInstalledIn: select listElement
]

{ #category : #'api - hooks' }
ToSelectFiltrableMode >> onUninstalledIn: aSelect [

	sieve onUninstalledIn: select listElement.
	filtrableListEventHandler := nil.
	sieve := nil.
	super onUninstalledIn: aSelect.
]

{ #category : #accessing }
ToSelectFiltrableMode >> pattern [

	^ sieve pattern
]

{ #category : #accessing }
ToSelectFiltrableMode >> pattern: aPattern [

	sieve pattern: aPattern
]

{ #category : #'accessing selection' }
ToSelectFiltrableMode >> selectIndex: anIndex [

	select isMultipleSelection ifFalse: [
		select listElement selecter selectOnlyIndex: anIndex.
		^ self ].
	select listElement selecter selectIndex: anIndex
]

{ #category : #accessing }
ToSelectFiltrableMode >> sieve [ 

	^ sieve
]
