Class {
	#name : #ToListAdditionalSelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#instVars : [
		'ownsSelecter'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #'api - hooks' }
ToListAdditionalSelectionMode >> installOptionsIn: anElement [

	overOption := (ToListSelectionOption groupedForMode: self)
		                 beneath: false;
		                 yourself.
	beneathOption := (ToListSelectionOption noneForMode: self)
		              beneath: true;
		              yourself.
	beneathOption onInstalledIn: anElement.
	overOption onInstalledIn: anElement.


]

{ #category : #'api - hooks' }
ToListAdditionalSelectionMode >> installSelecterIn: anElement [

	ownsSelecter := selecter parentSelecter subSelecterIndex
		                includesKey: selecter uniqueId.
	ownsSelecter ifFalse: [ super installSelecterIn: anElement ]
]

{ #category : #testing }
ToListAdditionalSelectionMode >> isMultipleSelection [

	^ true
]

{ #category : #'api - hooks' }
ToListAdditionalSelectionMode >> uninstallSelecterIn: anElement [

	ownsSelecter ifFalse: [ super uninstallSelecterIn: anElement ]
]
