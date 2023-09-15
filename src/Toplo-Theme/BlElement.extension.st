Extension { #name : #BlElement }

{ #category : #'*Toplo-Theme' }
BlElement >> childSkinsToHandle [
	" to be redefined by subclasses to declare how to manage the element properties skins "
	" each element is ToSubSkin "
 
	^ { }
]

{ #category : #'*Toplo-Theme' }
BlElement >> skinableSlots [

	^ self class slots select: [ :s | s isKindOf: ToSkinnableSlot ]
]
