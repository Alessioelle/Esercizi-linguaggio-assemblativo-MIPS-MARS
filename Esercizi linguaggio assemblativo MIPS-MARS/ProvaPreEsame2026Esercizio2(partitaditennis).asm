#Realizzare un programma in linguaggio assembly MIPS che simula la partita di tennis tra Sinner e Alcaraz. L’incontro si basa su tre partite (o set). 
#Ogni set è composto da un minimo di 6 giochi (o game) e per vincerlo è necessario conquistarne almeno sei con un vantaggio minimo di due (6-0, 6-1, 6-2, 6-3, 6-4 e 7-5). 
#Il regolamento del torneo prevede che sul punteggio di 6-6 si disputa tie-break, che chiude il set 7-6 o 6-7. Ad ogni turno un tennista genera un numero casuale da 0 a 10. 
#Il valore maggiore vince il gioco, nel caso di numero uguale entrambi vincono il gioco. 
#Stampare i risultati di tutte e tre le partite e decretare il vincitore.

.globl main

.data

stringainizio: .asciiz "Benvenuto all'incontro di tennis tra Sinner ed Alcaraz. Il programma genererà per lei un vincitore sulla base dei risultati casuali delle partite nei tre set di gioco previsti."
stringastart: .asciiz "Inserisca ora il numero '1' per iniziare il gioco. Inserisca invece un altro intero qualsiasi se non intende proseguire:"
stringafine: .asciiz "Che peccato! Non ha desiderato giocare con noi. La aspettiamo per un nuovo entusiasmante incontro!"
stringagioco: .asciiz "Iniziamo!"
stringarisultato1: .asciiz "La partita è stata molto avvincente! Il vincitore è"
stringacomune: .asciiz "con un risultato di "
stringacomune1: .asciiz " a "
stringafine1: .asciiz "Il vincitore finale della partita è quindi Sinner "
stringafine2: .asciiz "Il vincitore finale della partita è quindi Alcaraz "
sinner: .asciiz "Sinner"
alcaraz: .asciiz "Alcaraz"
spazio: .asciiz "\t"
acapo: .asciiz "\n"
.text

main:                             #stampo a schermo le istruzioni iniziali per l'utente
li $v0,4
la $a0,stringainizio
syscall
li $v0,4
la $a0,acapo
syscall
li $v0,4
la $a0,acapo
syscall
li $v0,4
la $a0,stringastart
syscall
li $v0,5                          #se l'utente non vuole giocare stampo la stringa chiusuraanticipata a schermo e termino esecuzione del programma
syscall
bne $v0,1,chiusuraanticipata
li $v0,4            
la $a0,acapo
syscall
li $v0,4                          #altrimenti proseguo con il gioco automatico
la $a0,stringagioco           
syscall
li $v0,4
la $a0,acapo
syscall
li $t1,0                          #inizializzo contatore set
li $a1,11                         #limite massimo producibile numero random giocatore
li $t6,0                          #inizializzo contatore risultati set sinner
li $t7,0                          #inizializzo contatore risultati set alcaraz
contaset:
addi $t1,$t1,1                    #sommo 1 in $t1 ad ogni set effettuato
bgt $t1,3,fine                    #effettuati tre set salto a fine per la stampa dei risultati finali a schermo
li $t4,0                          #inizializzo contatore risultati giochi sinner
li $t5,0                          #inizializzo contatore risultati giochi alcaraz
set:                              #ciclo ricorsivo per ogni gioco del set di riferimento
li $v0,42                         #genero numero casuale per sinner e lo metto in $t2
syscall
move $t2,$a0                           
li $v0,42                         #genero numero casuale per alcaraz e lo metto in $t3
syscall
move $t3,$a0
bgt $t2,$t3,vincesinner           #se numero in $t2 maggiore di numero in $t3 vince sinner e salto ad istruzioni per salvataggio vincita sinner
blt $t2,$t3,vincealcaraz          #se numero in $t2 minore di numero in $t3 vince alcaraz e salto ad istruzioni per salvataggio vincita alcaraz
addi $t4,$t4,1                    #se i numeri generati e salvati in $t2 e $t3 sono invece uguali assegno un punto a ciascun giocatore 
addi $t5,$t5,1
beq $t4,7,fineset1                #se uno dei due giocatori ha raggiunto 7 giochi vinti salto al fineset che stampa il risultato del set in base al vincitore
beq $t5,7,fineset2
bgt $t4,5,controllofineset1       #se uno dei due giocatori ha raggiunto 6 giochi vinti salto al controllofineset che monitora la parte critica del set (situazioni intorno al 6)
bgt $t5,5,controllofineset2
j set                             #altrimenti ciclo set

vincesinner:
addi $t4,$t4,1                  #metto risultato gioco sinner in $t4
beq $t4,7,fineset1              #se sinner ha raggiunto 7 giochi vinti salto al fineset che stampa il risultato del set in base al vincitore
bgt $t4,5,controllofineset1     #se sinner ha raggiunto 6 giochi vinti salto al controllofineset che monitora la parte critica del set (situazioni intorno al 6)
j set                           #altrimenti ciclo set
vincealcaraz:
addi $t5,$t5,1                  #metto risultato gioco alcaraz in $t5
beq $t5,7,fineset2              #se alcaraz ha raggiunto 7 giochi vinti salto al fineset che stampa il risultato del set in base al vincitore
bgt $t5,5,controllofineset2     #se alcaraz ha raggiunto 6 giochi vinti salto al controllofineset che monitora la parte critica del set (situazioni intorno al 6)
j set                           #altrimenti ciclo set

controllofineset1:              #dopo 6 giochi controllo se sinner ha vinto il set
add $t0,$t4,$t5                 #sommo il numero di giochi vinti da sinner e da alcaraz
ble $t0,10,fineset1             #se somma minore di 10 termino ciclo e stampo vincitore sinner (sicuramente uno dei due giocatori ha raggiuntio 6 vincite e risultati compresi tra 6-0 e 6-4)
beq $t0,12,tiebreak             #se somma uguale a 12 abbiamo pareggio 6-6 e quindi salto a tiebreak per evitare di generare due numeri uguali che porterebbero ad un ulteriore pareggio
j set                           #se nessuna delle condizioni di cui sopra si è ancora verificata salto a ciclo set
controllofineset2:              #dopo 6 giochi controllo se alcaraz ha vinto il set
add $t0,$t4,$t5                 #sommo il numero di giochi vinti da sinner e da alcaraz
ble $t0,10,fineset2             #se somma minore di 10 termino ciclo e stampo vincitore alcaraz (sicuramente uno dei due giocatori ha raggiuntio 6 vincite e risultati compresi tra 6-0 e 6-4)
beq $t0,12,tiebreak             #se somma uguale a 12 abbiamo pareggio 6-6 e quindi salto a tiebreak per evitare di generare due numeri uguali che porterebbero ad un ulteriore pareggio
j set                           #se nessuna delle condizioni di cui sopra si è ancora verificata salto a ciclo set

tiebreak:                       #salto a tiebreak solo nel caso i giochi abbiano portato ad un risultato di 6-6 e quindi non mi posso permettere generazione di pareggi
li $v0,42                       #genero numero casuale per sinner e lo metto in $t2
syscall
move $t2,$a0
li $v0,42                       #genero numero casuale per alcaraz e lo metto in $t3
syscall
move $t3,$a0
beq $t2,$t3,tiebreak            #se i due numeri casuali generati sono uguali scarto e procedo a ciclare di nuovo
bgt $t2,$t3,vincesinner         #se il primo è maggiore del secondo vince sinner
blt $t2,$t3,vincealcaraz        #se il primo è minore del secondo vince alcaraz


fineset1:                       #vince il set sinner e stampo a schermo il risultato del set
li $v0,4
la $a0,acapo
syscall
li $v0,4
la $a0,stringarisultato1
syscall
li $v0,4
la $a0,spazio
syscall
li $v0,4
la $a0,sinner
syscall
li $v0,4
la $a0,spazio
syscall
li $v0,4
la $a0,stringacomune
syscall
li $v0,1
move $a0,$t4
syscall
li $v0,4
la $a0,stringacomune1
syscall
li $v0,1
move $a0,$t5
syscall
addi $t6,$t6,1                #conta set vinto da sinner
j contaset


fineset2:                     #vince il set alcaraz e stampo a schermo il risultato del set
li $v0,4 
la $a0,acapo
syscall
li $v0,4
la $a0,stringarisultato1
syscall
li $v0,4
la $a0,spazio
syscall
li $v0,4
la $a0,alcaraz
syscall
li $v0,4
la $a0,spazio
syscall
li $v0,4
la $a0,stringacomune
syscall
li $v0,1
move $a0,$t5
syscall
li $v0,4
la $a0,stringacomune1
syscall
li $v0,1
move $a0,$t4
syscall
addi $t7,$t7,1               #conta set vinto da alcaraz
j contaset

fine:                        #terminati i tre set stampo a schermo il vincitore e dichiaro il risultato finale
sgt $t0,$t6,$t7              #imposto ad 1 il registro $t0 se vince sinner altrimenti imposto a zero
beqz $t0,fine2               #se il registro $t0 è impostato a zero salto a istruzioni per la stampa vincita finale di alcaraz
fine1:                       #stampo a schermo vincita partita sinner
li $v0,4
la $a0,acapo
syscall
li $v0,4
la $a0,acapo
syscall
li $v0,4
la $a0,stringafine1
syscall
li $v0,4
la $a0,stringacomune
syscall
li $v0,1
move $a0,$t6
syscall
li $v0,4
la $a0,stringacomune1
syscall
li $v0,1
move $a0,$t7
syscall
j chiusura
fine2:                        #stampo a schermo vincita partita alcaraz
li $v0,4
la $a0,acapo
syscall
li $v0,4
la $a0,acapo
syscall
li $v0,4
la $a0,stringafine2
syscall
li $v0,4
la $a0,stringacomune
syscall
li $v0,1
move $a0,$t7
syscall
li $v0,4
la $a0,stringacomune1
syscall
li $v0,1
move $a0,$t6
syscall
chiusura:                    #chiudo per fine partita
li $v0,10
syscall

chiusuraanticipata:          #chiudo perchè utente non vuole giocare
li $v0,4
la $a0,acapo
syscall
li $v0,4
la $a0,stringafine
syscall
li $v0,10
syscall
