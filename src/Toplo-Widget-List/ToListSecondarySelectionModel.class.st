Class {
	#name : #ToListSecondarySelectionModel,
	#superclass : #ToListStandardSelectionModel,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #'api - hooks' }
ToListSecondarySelectionModel >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	unselectableSelecter := aListElement unselectableSelecter.
	disabledSelecter := aListElement disabledSelecter.
	hiddenSelecter := aListElement hiddenSelecter.


]

{ #category : #'api - hooks' }
ToListSecondarySelectionModel >> onUninstalledIn: aListElement [

	unselectableSelecter := nil.
	disabledSelecter := nil.
	hiddenSelecter := nil.
	super onInstalledIn: aListElement.



]
