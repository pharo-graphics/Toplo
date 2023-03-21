Extension { #name : #BlElement }

{ #category : #'*Toplo' }
BlElement >> addedInSelectionDecoration: aSelectionDecoration [
]

{ #category : #'*Toplo' }
BlElement >> blurSelectedItemBackground [

	^ self selectedItemBackground muchLighter
]

{ #category : #'*Toplo' }
BlElement >> deselectedInInfiniteElement [
]

{ #category : #'*Toplo' }
BlElement >> holder [

	^ self constraints infinite holder
]

{ #category : #'*Toplo' }
BlElement >> removedFromSelectionDecoration: aSelectionDecoration [
]

{ #category : #'*Toplo' }
BlElement >> selectedInInfiniteElement [
]

{ #category : #'*Toplo' }
BlElement >> selectedItemBackground [

	^ self theme item selectedColor
]
