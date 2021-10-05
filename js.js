function generateCard(bin){
    var bin2 = "";
    var bin2_l = [];
    var card = "";
    var card1_l = [];
    var card2_l = [];
    var sum = 0;
    var mod = 0;
    var check_sum = 0;
    for (var i in bin){
        char = bin[i].toLowerCase();
        if (char == "x"){
            var rand_num = Math.floor(Math.random() * 10);
            char = rand_num;
        }
        bin2 += char;
    }
    for (var i in bin2){
        bin2_l.push(parseInt(bin2[i]))
    }
    // Push bin2_l to card1_l
    for (var i in bin2_l){
        card1_l.push(bin2_l[i]);
        card2_l.push(bin2_l[i]);
    }
    //  Generate numbers
    for (var i = 0; i < 15 - bin.length; i++){
        var rand_num = Math.floor(Math.random() * 10);
        card1_l.push(rand_num);
        card2_l.push(rand_num);
    }
    // Odd
    for (var i = 0; i < card2_l.length; i += 2){
        card2_l[i] *= 2;
    }
    // Subtract
    for (var i in card2_l){
        if (card2_l[i] > 9){
            card2_l[i] -= 9;
        }
    }
    // Sum
    for (var i in card2_l){
        sum += card2_l[i];
    }
    mod = sum % 10;
    if (!mod == 0){
        check_sum = 10 - mod;
    }
    card1_l.push(check_sum);
    // Finally
    for (var i in card1_l){
        card += card1_l[i];
    }
    return card;
}

(function() {
    var bin = '548876xxxxxxxxx'
    var generatedCard = generateCard(bin);
    
        return generatedCard;
    })();


