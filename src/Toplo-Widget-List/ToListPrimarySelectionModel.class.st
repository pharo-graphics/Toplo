Class {
	#name : #ToListPrimarySelectionModel,
	#superclass : #ToListElementSelectionModel,
	#instVars : [
		'dependentSelectionModelIndex'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #accessing }
ToListPrimarySelectionModel >> changeSelectionModelWithId: aUniqueId withModel: aSelectionModel [

	self unrecordDependentSelectionModel:
		(self dependentSelectionModelWithId: aUniqueId).
	aSelectionModel ifNil: [ ^ self ].
	aSelectionModel uniqueId: aUniqueId.
	self recordDependentSelectionModel: aSelectionModel
]

{ #category : #accessing }
ToListPrimarySelectionModel >> dependentSelectionModelIndex [

	^ dependentSelectionModelIndex
]

{ #category : #accessing }
ToListPrimarySelectionModel >> disabledSelectionModel [

	^ self dependentSelectionModelWithId: #disabled 
]

{ #category : #accessing }
ToListPrimarySelectionModel >> disabledSelectionModel: aSelectionModel [

	self changeSelectionModelWithId: #disabled withModel: aSelectionModel
]

{ #category : #accessing }
ToListPrimarySelectionModel >> hiddenSelectionModel [

	^ self dependentSelectionModelWithId: #hidden 
]

{ #category : #accessing }
ToListPrimarySelectionModel >> hiddenSelectionModel: aSelectionModel [

	self changeSelectionModelWithId: #hidden withModel: aSelectionModel
]

{ #category : #'api - hooks' }
ToListPrimarySelectionModel >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	dependentSelectionModelIndex := SmallIdentityDictionary new
]

{ #category : #'api - hooks' }
ToListPrimarySelectionModel >> onUninstalledIn: aListElement [

	super onUninstalledIn: aListElement.
	dependentSelectionModelIndex empty.
	dependentSelectionModelIndex := nil
]

{ #category : #accessing }
ToListPrimarySelectionModel >> recordDependentSelectionModel: aSelectionModel [

	aSelectionModel ifNil: [ ^ self ].
	dependentSelectionModelIndex
		at: aSelectionModel uniqueId
		ifPresent: [
		Error signal: 'A selection model with the same id already exists' ].
	dependentSelectionModelIndex
		at: aSelectionModel uniqueId
		put: aSelectionModel
]

{ #category : #accessing }
ToListPrimarySelectionModel >> uniqueId [

	^ #primary
]

{ #category : #accessing }
ToListPrimarySelectionModel >> unrecordDependentSelectionModel: aSelectionModel [

	aSelectionModel ifNil: [ ^ self ].
	dependentSelectionModelIndex removeKey:
		aSelectionModel uniqueId
]

{ #category : #accessing }
ToListPrimarySelectionModel >> unselectableSelectionModel [

	^ self dependentSelectionModelWithId: #unselectable 
]

{ #category : #accessing }
ToListPrimarySelectionModel >> unselectableSelectionModel: aSelectionModel [

	self
		changeSelectionModelWithId: #unselectable
		withModel: aSelectionModel
]
